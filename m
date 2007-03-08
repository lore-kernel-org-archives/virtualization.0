From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 00/17] Paravirt_ops for x86_64
Date: Thu, 08 Mar 2007 01:01:44 -0500
Message-ID: <1173333704.25848.0.camel@localhost.localdomain>
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
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

Glauber and I have been playing around with getting paravirt ops working
on the x86_64.  We have our own version of lguest running there too.
We have lguest64 running up to console_init, and then it takes an
interrupt storm.  I'll be posting those patches tomorrow.

Glauber and I have been sharing a git repo that isn't open to the public.
(we don't want people to see how crappy our stuff is yet ;)
Well, it's still kind of crappy, but it's starting to work. So I spent
today, pulling out patches related only to paravirt ops from our git
repo, and separating them to be readable. Well, here they are.

Tomorrow, I'll post what we got for lguest64 running.

Thanks!

-- Steve




--
