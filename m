From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-blk: Disable callback in virtblk_done()
Date: Fri, 28 Sep 2012 15:38:56 +0930
Message-ID: <87fw623chz.fsf@rustcorp.com.au>
References: <1348540577-7474-1-git-send-email-asias@redhat.com>
	<5061BAED.9020205@redhat.com> <87ehlo497o.fsf@rustcorp.com.au>
	<5063F6D2.7030908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5063F6D2.7030908@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Asias He <asias@redhat.com> writes:
>> I forgot about the cool hack which MST put in to defer event updates
>> using disable_cb/enable_cb.
>
> Hmm, are you talking about virtqueue_enable_cb_delayed()?

Just the fact that virtqueue_disable_cb() prevents updates of
used_index, and then we do the update in virtqueue_enable_cb().

Cheers,
Rusty.
