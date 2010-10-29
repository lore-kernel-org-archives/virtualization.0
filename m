From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] xen: xenfs: privcmd: check put_user() return code
Date: Fri, 29 Oct 2010 10:52:59 -0700
Message-ID: <4CCB09FB.8050906@goop.org>
References: <1288265942-12581-1-git-send-email-segooon@gmail.com>	 <4CCB01C9.4020007@goop.org> <1288374270.8069.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1288374270.8069.41.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Campbell <Ian.Campbell@eu.citrix.com>
Cc: Vasiliy Kulikov <segooon@gmail.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

 On 10/29/2010 10:44 AM, Ian Campbell wrote:
> On Fri, 2010-10-29 at 18:18 +0100, Jeremy Fitzhardinge wrote:
>> On 10/28/2010 04:39 AM, Vasiliy Kulikov wrote:
>>> put_user() may fail.  In this case propagate error code from
>>> privcmd_ioctl_mmap_batch().
>> Thanks for looking at this.  I'm in two minds about this; the existing
>> logic is such that these put_users can only fail if something else has
>> already failed and its returning an error.  I guess it would be useful
>> to get an EFAULT if you've got a problem writing back the results.
>>
>> IanC, any opinion?
> Not a strong one.
>
> Perhaps what we really want in this case is for traverse_pages to return
> the total number of callback failures it encountered rather than
> aborting after the first failure?
>
> On the other hand you are correct that gather_array() has already
> touched all the pages which we are going to be touching here so how
> likely is a new failure at this point anyway?

I could think of two cases: the array is mapped RO, so only the
writeback fails, or someone changes the mapping under our feet from
another thread.

    J

> Ian.
>
>> Thanks,
>>     J
>>
>>> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
>>> ---
>>>  Compile tested.
>>>
>>>  drivers/xen/xenfs/privcmd.c |    8 ++------
>>>  1 files changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/xen/xenfs/privcmd.c b/drivers/xen/xenfs/privcmd.c
>>> index f80be7f..2eb04c8 100644
>>> --- a/drivers/xen/xenfs/privcmd.c
>>> +++ b/drivers/xen/xenfs/privcmd.c
>>> @@ -266,9 +266,7 @@ static int mmap_return_errors(void *data, void *state)
>>>  	xen_pfn_t *mfnp = data;
>>>  	struct mmap_batch_state *st = state;
>>>  
>>> -	put_user(*mfnp, st->user++);
>>> -
>>> -	return 0;
>>> +	return put_user(*mfnp, st->user++);
>>>  }
>>>  
>>>  static struct vm_operations_struct privcmd_vm_ops;
>>> @@ -323,10 +321,8 @@ static long privcmd_ioctl_mmap_batch(void __user *udata)
>>>  	up_write(&mm->mmap_sem);
>>>  
>>>  	if (state.err > 0) {
>>> -		ret = 0;
>>> -
>>>  		state.user = m.arr;
>>> -		traverse_pages(m.num, sizeof(xen_pfn_t),
>>> +		ret = traverse_pages(m.num, sizeof(xen_pfn_t),
>>>  			       &pagelist,
>>>  			       mmap_return_errors, &state);
>>>  	}
>
