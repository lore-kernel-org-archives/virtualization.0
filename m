From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 0/5] Add vhost-blk support
Date: Fri, 13 Jul 2012 09:19:55 +0800
Message-ID: <4FFF77BB.2040605__26733.0659124584$1342142293$gmane$org@redhat.com>
References: <1342107302-28116-1-git-send-email-asias@redhat.com>
	<x498vepklqu.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <x498vepklqu.fsf@segfault.boston.devel.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hello Jeff,

On 07/13/2012 12:06 AM, Jeff Moyer wrote:
> Asias He <asias@redhat.com> writes:
>
>> Hi folks,
>>
>> This patchset adds vhost-blk support. vhost-blk is a in kernel virito-blk
>> device accelerator. Compared to userspace virtio-blk implementation, vhost-blk
>> gives about 5% to 15% performance improvement.
>>
>> Asias He (5):
>>    aio: Export symbols and struct kiocb_batch for in kernel aio usage
>>    eventfd: Export symbol eventfd_file_create()
>>    vhost: Make vhost a separate module
>>    vhost-net: Use VHOST_NET_FEATURES for vhost-net
>>    vhost-blk: Add vhost-blk support
>
> I only saw patches 0 and 1.  Where are the other 4?  If the answer is,
> "not on lkml," then please resend them, CC'ing lkml.

I did send all the 0-5 patches to lkml, but I somehow messed up the 
thread. Will CC you next time.

> I'd like to be able to see the usage of the aio routines.

OK. It'd be nice if you could review. Thanks.

-- 
Asias
