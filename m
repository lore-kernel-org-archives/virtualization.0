From: Andi Kleen <ak@suse.de>
Subject: Re: Patch: use .pushsection/.popsection
Date: Wed, 9 Aug 2006 08:26:21 +0200
Message-ID: <200608090826.21157.ak@suse.de>
References: <44D97A62.9020106@vmware.com> <44D97C03.9080709@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44D97C03.9080709@goop.org>
Content-Disposition: inline
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
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 09 August 2006 08:09, Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
> > I think this might fix the X bug...
> I just posted an equivalent patch to Andi Kleen/AKPM/LKML.  I haven't =

> tested to see if it actually helps yet, but it certainly makes entry.o =

> look a lot cleaner.

I have already merged it.

But in theory all code should run fine in .fixup, so it shouldn't
actually unbreak anything.

-Andi
