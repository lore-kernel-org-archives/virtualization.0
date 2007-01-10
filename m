From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Oops
Date: Wed, 10 Jan 2007 11:38:06 -0800
Message-ID: <45A5409E.50507@goop.org>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A4A0C7.5050405@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> config is attached.
>
> It faults in fork syscall, down in pgd_walk().  It finds a pmd entry
> pointing to a machine page where the mfn_to_pfn translation returns -1
> aka 0xffffffff.  Trying to find a struct page for that one doesn't work .=
..
>   =


Hm, that's interesting but curious.  Hm, the mapping is in userspace? =

How did userspace get a foreign/special mapping?

Is this the very first fork()?  Nothing should be mapped down there at
all, so maybe there's a bug in initial pagetable setup.

    J
