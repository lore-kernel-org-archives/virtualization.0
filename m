From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-blk: Don't free ida when disk is in use
Date: Thu, 20 Dec 2012 14:45:13 +1030
Message-ID: <878v8t1hri.fsf@rustcorp.com.au>
References: <1355946015-25879-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1355946015-25879-1-git-send-email-agraf@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>, virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Alexander Graf <agraf@suse.de> writes:

> When a file system is mounted on a virtio-blk disk, we then remove it
> and then reattach it, the reattached disk gets the same disk name and
> ids as the hot removed one.
>
> This leads to very nasty effects - mostly rendering the newly attached
> device completely unusable.
>
> Trying what happens when I do the same thing with a USB device, I saw
> that the sd node simply doesn't get free'd when a device gets forcefully
> removed.
>
> Imitate the same behavior for vd devices. This way broken vd devices
> simply are never free'd and newly attached ones keep working just fine.
>
> Signed-off-by: Alexander Graf <agraf@suse.de>

I think deserves a CC:stable, no?

I've put it in my pending queue for *next* merge window for now...

Thanks,
Rusty.
