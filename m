From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH] x86_64 paravirt_ops port
Date: Tue, 9 Jan 2007 09:14:23 -0200
Message-ID: <20070109111423.GB5193@redhat.com>
References: <20070108140826.GA1624@redhat.com>
	<1168297540.19646.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1168297540.19646.40.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

 =

> There's one critical bug which will stop it from booting reliably:
> > +    Based on i386 work by Rusty Russel.
> =

Thanks for the tip, Rusty. In fact, I fixed that, and the random crashes
disappeared. ;-)

-- =

Glauber de Oliveira Costa
Red Hat Inc.
"Free as in Freedom"
