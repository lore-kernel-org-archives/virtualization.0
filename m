From: Thomas Huth <thuth@linux.vnet.ibm.com>
Subject: Virtio-net, ethtool and rx-checksumming
Date: Fri, 23 Aug 2013 08:52:52 +0200
Message-ID: <20130823085252.56692143@thhw500>
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
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


 Hi all,

when running "ethtool -k ethX" on a virtio-net device, it always
reports "rx-checksumming: off" with recent kernels. With older kernels
(e.g. 2.6.32), it used to report "on" instead, so this difference
caused some confusion here ("do newer guest kernels have to compute the
RX checksums now? That's certainly a bug / performance problem ...").

However, after inspecting the code a little bit, it seems to me that
this ethtool setting is not taken care of by the virtio_net driver at
all, so the values reported by ethtool seem to be rather arbitrary than
on purpose.

Now my question: Would it make sense to map the "rx-checksumming"
reporting to the VIRTIO_NET_F_GUEST_CSUM feature bit, so that the user
of the guest system can see whether the guest OS has to calculate RX
checksums or not? I guess it does not make sense to also make this
configurable during run-time, but IMHO it really would be good if at
least the reporting was available.

 Regards,
  Thomas Huth
