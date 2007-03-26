From: James Morris <jmorris@namei.org>
Subject: [LGUEST] updated nohz/hrtimer WIP patches (v02)
Date: Mon, 26 Mar 2007 12:11:07 -0400 (EDT)
Message-ID: <Line.LNX.4.64.0703261148040.13138@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

At http://namei.org/misc/lguest/patches/time/v02/

Current status:
- Resync to recent upstream lguest patch queue
- Rudimentary clock event device is working, but with a significant =

  performance hit
- Old TSC code included, still needs to be modified to handle freq change

Next:
- Check for pending interrupts after they're enabled again per suggestion =

  from Rusty.



-- =

James Morris
<jmorris@namei.org>
