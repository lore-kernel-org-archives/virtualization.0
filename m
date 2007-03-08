From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [RFC/PATCH PV_OPS X86_64 00/17] Paravirt_ops for x86_64
Date: Wed, 7 Mar 2007 22:47:29 -0800
Message-ID: <20070308064729.GZ10574@sequoia.sous-sol.org>
References: <1173333704.25848.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1173333704.25848.0.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

* Steven Rostedt (rostedt@goodmis.org) wrote:
> Well, it's still kind of crappy, but it's starting to work. So I spent
> today, pulling out patches related only to paravirt ops from our git
> repo, and separating them to be readable. Well, here they are.

Cool.  I had split these up slightly differently, with core changes
coming first (like places where raw asm is still left behind), followed
by adding in the paravirt bits.  I think it would be useful to get those
simple basic changes to the front of the queue, because they can
largely be merged right away w/out issue.  I'll look through the lot
tomorrow.

thanks,
-chris
