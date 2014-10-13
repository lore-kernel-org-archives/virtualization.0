From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC 03/11] virtio: support more feature bits
Date: Mon, 13 Oct 2014 12:55:11 +0200
Message-ID: <20141013125511.5d3475ab.cornelia.huck@de.ibm.com>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
	<1412692807-12398-4-git-send-email-cornelia.huck@de.ibm.com>
	<87bnpgecqx.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87bnpgecqx.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 13 Oct 2014 16:23:58 +1030
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> > With virtio-1, we support more than 32 feature bits. Let's make
> > vdev->guest_features depend on the number of supported feature bits,
> > allowing us to grow the feature bits automatically.
> 
> It's a judgement call, but I would say that simply using uint64_t
> will be sufficient for quite a while.

I prefer this as an array for two reasons:

- It matches what ccw does anyway (we read/write features in chunks of
  32 bit), so this makes the backend handling for this transport very
  straightforward.
- While I don't see us running out of 64 feature bits for a while, we'd
  have to touch every device and transport again when we do. I'd prefer
  to do this once, as we need to change code anyway.
