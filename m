From: Dor Laor <dor.laor@gmail.com>
Subject: [Virtio-for-kvm] [PATCH 0/7] userspace virtio
Date: Fri, 21 Dec 2007 16:42:44 +0200
Message-ID: <476BD0E4.3040509__40124.5714318522$1198248297$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rus>
List-Id: virtualization@lists.linuxfoundation.org

This patchset updates kvm repository with Anthony's virtio 
implementation along
with rx performance improvements and guest reset handling.
The original code was sent to qemu devel list 2 weeks ago.
It contains support for network & block devices.

Using the performance improvement I was able to do 800Mbps for rx/tx.
The performance improvement are not implemented in a qemu standard code but
the intention is to first let the community have decent performance with 
a merged virtio and
afterwards do the polishing (there is dma support on the way for qemu).

Enjoy [with the courtesy of Anthony & Rusty],
Dor
