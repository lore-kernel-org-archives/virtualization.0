From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Slackware-11.0, Kernel-2.6.20, lguest-137.patch : compiling
	problem
Date: Thu, 08 Feb 2007 11:48:24 +1100
Message-ID: <1170895704.11736.31.camel@localhost.localdomain>
References: <20070207174431.61f285cd@nmr3.ioc.ac.ru>
	<1170892466.11736.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1170892466.11736.26.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: strel@ioc.ac.ru
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-02-08 at 10:54 +1100, Rusty Russell wrote:
> Perhaps I accidentally used a new gas feature?

OK, I grabbed slackware 11's binutils, and !=3D wasn't valid in .if
expressions in binutils 2.15.  "<>" is more portable.

Fixed and pushed: thanks for the report!
Rusty.
