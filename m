From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [ANNOUNCE] virtbench now has xen support
Date: Tue, 15 May 2007 12:38:26 +1000
Message-ID: <1179196706.27304.22.camel__18982.4262205095$1179196786$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Xen Mailing List <xen-devel@lists.xensource.com>
Cc: virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

	I've been working on a set of easy-to-run benchmarks for hypervisor
optimization called virtbench, and the latest commit adds Xen support.

	http://ozlabs.org/~rusty/virtbench
	http://ozlabs.org/~rusty/virtbench/?archive/tip.tar.bz2

From the README:

	# Build the code
	make
	# Set the guest kernel location and maybe more
	vi ./SETTINGS
	# Run the benchmark (local mode)
	./virtbench local
	# Run the benchmark (kvm mode)
	sudo ./virtbench kvm
	# Run the benchmark (Xen mode)
	sudo ./virtbench xen
	# Run the benchmark (lguest mode)
	sudo ./virtbench lguest

Feedback welcome!
Rusty.
