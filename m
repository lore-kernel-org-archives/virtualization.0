From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [RFC PATCH 1/5] lguest: mmap backing file
Date: Sun, 23 Mar 2008 11:11:02 +0200
Message-ID: <47E61EA6.4080506__19298.8950912424$1206263590$gmane$org@qumranet.com>
References: <200803201659.14344.rusty@rustcorp.com.au>	<200803201705.44422.rusty@rustcorp.com.au>	<47E26EE1.5030706@codemonkey.ws>	<200803210912.25648.rusty@rustcorp.com.au>
	<47E2F75F.2040808@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E2F75F.2040808@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
>>>     
>>>       
>> If we're going to mod the kernel, how about a "mmap this part of their address 
>> space" and having the kernel keep the mappings in sync.  But I think that if 
>> we want to get speed, we should probably be doing the copy between address 
>> spaces in-kernel so we can do lightweight exits.
>>   
>>     
>
> I don't think lightweight exits help the situation very much.  The 
> difference between a light weight and heavy weight exit is only 3-4k 
> cycles or so.
>   

On what host cpu?  IIRC the difference was bigger on Intel (and in 
relative terms, set to increase).

> in-kernel doesn't make the situation much easier.  You have to map pages 
> in from a different task.  It's a lot easier if you have both guest 
> mapped in userspace.
>   

The kernel already has everything mapped (kmap_atomic() is an addition 
on x86_64).



-- 
error compiling committee.c: too many arguments to function
