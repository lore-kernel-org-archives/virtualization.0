From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0/11] RFC: PCI using capabilitities
Date: Thu, 08 Dec 2011 20:52:38 +1030
Message-ID: <87pqfzgy6p.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization <virtualization@lists.linux-foundation.org>
Cc: Avi Kivity <avi@redhat.com>, Sasha Levin <levinsasha928@gmail.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Here's the patch series I ended up with.  I haven't coded up the QEMU
side yet, so no idea if the new driver works.

Questions:
(1) Do we win from separating ISR, NOTIFY and COMMON?
(2) I used a "u8 bar"; should I use a bir and pack it instead?  BIR
    seems a little obscure (noone else in the kernel source seems to
    refer to it).

Cheers,
Rusty.
