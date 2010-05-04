From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: implementation of IEEE 802.1Qbg in lldpad, part1
Date: Tue,  4 May 2010 13:47:46 +0200
Message-ID: <1272973669-6694-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: e1000-eedc@lists.sourceforge.net, virtualization@lists.linux-foundation.org, evb@yahoogroups.com
Cc: chrisw@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

this series of patches contains an implementation of the first part
of IEEE 802.1Qbg, the exchange of EVB TLVs to negotiate VSI capabalities.

It supports setting the parameters of the TLV exchange from the command
line using lldptool.

The patches are based on lldpad 0.9.34. lldpad is a project hosted on
sourceforge.net. For more information about lldpad take a look at

http://sourceforge.net/projects/e1000/files/

section "DCB Tools / lldpad".

best regards,

Jens
