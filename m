From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: implementation of IEEE 802.1Qbg in lldpad
Date: Wed, 25 Aug 2010 14:27:32 +0200
Message-ID: <1282739262-14968-1-git-send-email-jens@linux.vnet.ibm.com>
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

The patches have been rebased to lldpad 0.9.38 and still contain code to log
low-level protocol activity more verbosely than necessary.

In comparison to the last posted series, several changes have been made:

 - all EVB TLV patches have been folded into one

 - ECP and VDP implementation now only consists of 3 patches: ECP, VDP and VDP
   commandline interface

 - the protocol specific ecp structure has been moved away from the general
   port structure

 - the non-standard ECP_TX_IDLE state has been removed from the ECP TX state
   machine which causes ecp frames to be sent out immediately to allow sequence
   synchronization

 - VDP subtype has changed from 0 to 2

 - some network byte order in the VSI tlv have been fixed

 - vdp config variables are now saved in subsection "vdp" under the interface
   in lldpad.conf

 - some compiler warnings have been fixed

 - many other small bug fixes

For more information about lldpad take a look at

http://sourceforge.net/projects/e1000/files/DCB%20Tools/lldpad/

Please review and comment.

Thanks !

                        Jens
