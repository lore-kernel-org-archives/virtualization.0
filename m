From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] vhost-blk: Add vhost-blk support v2
Date: Thu, 18 Oct 2012 14:50:56 +1030
Message-ID: <87d30go1g7.fsf@rustcorp.com.au>
References: <1349769918-8611-1-git-send-email-asias@redhat.com>
	<20121011124125.GA8074@redhat.com> <507818BE.7060404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <507818BE.7060404@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Asias He <asias@redhat.com> writes:
>>> +#define BLK_HDR	0
>> 
>> What's this for, exactly? Please add a comment.
>
> The block headr is in the first and separate buffer.

Please don't assume this!  We're trying to fix all the assumptions in
qemu at the moment.

vhost_net handles this correctly, taking bytes off the descriptor chain
as required.

Thanks,
Rusty.
