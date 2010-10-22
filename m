From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: implementation of IEEE 802.1Qbg in lldpad
Date: Fri, 22 Oct 2010 13:26:51 +0200
Message-ID: <1287746820-6036-1-git-send-email-jens@linux.vnet.ibm.com>
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

Hi,

this set of patches contains the initial implementation of the IEEE 802.1Qbg
standard: code for the exchange of EVB TLVs in LLDP frames to negotiate VSI
capabalities as well as VDP VSI TLVs between a host with virtual machines
and an adjacent switch.

It supports setting the parameters of the TLV exchange from the command
line using lldptool.

VDP profiles consisting of mode,mgrid,typeid,typeidversion,instanceid,mac,vlan
can be given to lldpad with lldptool or sent to lldpad via netlink messages from
the kernel or another program, e.g. libvirt.

VDP profiles are processed through the VDP/VSI and ECP state machines and
sent out in ECP frames.
ACK frames are received and processed through ECP and VDP/VSI state machines.

It implements a VDP bridge role for a port together with a lldptool command to
switch a port to the bridge role.

These patches apply against lldpad 0.9.38. Protocol debug messages are now logged
to syslog via LLDPAD_* macros and no longer to console. If you want to see them,
configure your syslog daemon to collect debug messages and start lldpad with -V 7.

 - improved cleanup in case of interface down
 - improved checking if a port really exists
 - converted all our code to use LLDPAD_ log messages
 - addressed Johns comments
 - modified EVB TLV defaults
 - increase max number of VSIs to 64k
 - fixed a number of bugs and memleaks

For more information about lldpad take a look at

http://sourceforge.net/projects/e1000/files/DCB%20Tools/lldpad/

Please review and comment.

Thank you !

                        Jens
