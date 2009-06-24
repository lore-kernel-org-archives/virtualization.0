From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] virtio-serial: A guest <-> host interface for simple
	communication
Date: Wed, 24 Jun 2009 17:40:49 +0100
Message-ID: <20090624164049.GE14121@shareable.org>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> A few sample uses for a vmchannel are to share the host and guest
> clipboards (to allow copy/paste between a host and a guest), to
> lock the screen of the guest session when the vnc viewer is closed,
> to find out which applications are installed on a guest OS even when
> the guest is powered down (using virt-inspector) and so on.

Those all look like useful features.

Can you run an application to provide those features on a guest which
_doesn't_ have a vmchannel/virtio-serial support in the kernel?

Or will it be restricted only to guests which have QEMU-specific
support in their kernel?

-- Jamie
