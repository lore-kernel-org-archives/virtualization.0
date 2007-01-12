From: Rusty Russell <rusty@rustcorp.com.au>
Subject: lhype -> lguest
Date: Fri, 12 Jan 2007 13:47:48 +1100
Message-ID: <1168570068.31891.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization <virtualization@lists.osdl.org>
Cc: William von Hagen <vonhagen@vonhagen.org>, Ingo Molnar <mingo@elte.hu>, Sean Neakums <sneakums@zork.net>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

	Ingo was eloquantly passionate about hating the name lhype, so after
some debate (and importantly, the rejection of both "Wonkavisor" and
"Rustyvisor"), I decided to name it after the guest (which is what users
care about), not the hypervisor (which is what hackers care about).

Hence:
	lhype_add -> lguest
        lguest.ko -> lg
        /dev/lhba -> /dev/lgba

Thanks to everyone for the naming input!
Rusty.
