From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH RESEND 5/5] vhost-blk: Add vhost-blk support
Date: Wed, 18 Jul 2012 10:31:28 -0400
Message-ID: <x49fw8pb0ov.fsf__3845.99448084391$1342629374$gmane$org@segfault.boston.devel.redhat.com>
References: <1342169711-12386-1-git-send-email-asias@redhat.com>
	<1342169711-12386-6-git-send-email-asias@redhat.com>
	<x49mx2yyzi5.fsf@segfault.boston.devel.redhat.com>
	<50060FE8.4040607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50060FE8.4040607@redhat.com> (Asias He's message of "Wed, 18 Jul
	2012 09:22:48 +0800")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Asias He <asias@redhat.com> writes:

> On 07/18/2012 03:10 AM, Jeff Moyer wrote:
>> Asias He <asias@redhat.com> writes:
>>
>>> vhost-blk is a in kernel virito-blk device accelerator.
>>>
>>> This patch is based on Liu Yuan's implementation with various
>>> improvements and bug fixes. Notably, this patch makes guest notify and
>>> host completion processing in parallel which gives about 60% performance
>>> improvement compared to Liu Yuan's implementation.
>>
>> So, first off, some basic questions.  Is it correct to assume that you
>> tested this with buffered I/O (files opened *without* O_DIRECT)?
>>  I'm pretty sure that if you used O_DIRECT, you'd run into problems (which
>> are solved by the patch set posted by Shaggy, based on Zach Brown's work
>> of many moons ago).  Note that, with buffered I/O, the submission path
>> is NOT asynchronous.  So, any speedups you've reported are extremely
>> suspect.  ;-)
>
> I always used O_DIRECT to test this patchset. And I mostly used raw
> block device as guest image. Is this the reason why I did not hit the
> problem you mentioned. Btw, I do have run this patchset on image based
> file. I still do not see problems like IO hangs.

Hmm, so do the iovec's passed in point to buffers in userspace?  I
thought they were kernel buffers, which would have blown up in
get_user_pages_fast.

Cheers,
Jeff
