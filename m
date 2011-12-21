From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC] virtio_blk: fix config handler race
Date: Wed, 21 Dec 2011 11:03:31 +1030
Message-ID: <877h1qdaqs.fsf@rustcorp.com.au>
References: <20111207153901.GA23820@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111207153901.GA23820@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 7 Dec 2011 17:39:02 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Fix a theoretical race related to config work
> handler: a config interrupt might happen
> after we flush config work but before we
> reset the device. It will then cause the
> config work to run during or after reset.

Thanks for the reminder.  Apologies that this slipped through :(

> As a solution
> 1. flush after reset when we know there will be no more interrupts
> 2. add a flag to disable config access before reset

It's crude, but it works.  Applied.

If this happens again, do we want a "__virtio_device_disable" which
stops any interrupts from being delivered?  That would make this neater,
though the implementation might be a bit nasty.

Thanks,
Rusty.
