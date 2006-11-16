From: Rusty Russell <rusty@rustcorp.com.au>
Subject: lhype progress...
Date: Thu, 16 Nov 2006 21:36:16 +1100
Message-ID: <1163673377.9585.15.camel@localhost.localdomain>
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
To: James Morris <jmorris@namei.org>, Don Mullis <dwm@meer.net>, Tony Breeds <tony@bakeyournoodle.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

	Some of you know I've been working on a trivial in-kernel hypervisor to
demonstrate paravirt_ops.  The good news is that it works!  (And not
just for me!)  The bad news is that I haven't written any documentation
and now I'm going to be offline (moving to a farm) for several weeks.

	Nonetheless, if you're the kind of person who wants to poke around with
hypervisors, no doubt you can figure it out.  Tony Breeds might even
write a HOWTO.  There's certainly a lot to be done (see FIXMEs in the
code for example).  Console device, block device and inter-domain
networking all work.  From here it should be easy 8)

	So, you can download the patch "lhype.patch" from the paravirt
mercurial patch queue.  It should apply by itself to a recent -mm tree.

	http://ozlabs.org/~rusty/paravirt

Thanks, and have fun playing!
Rusty.
