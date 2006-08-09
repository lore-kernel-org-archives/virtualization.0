From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Patch: use .pushsection/.popsection
Date: Tue, 08 Aug 2006 23:09:07 -0700
Message-ID: <44D97C03.9080709@goop.org>
References: <44D97A62.9020106@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44D97A62.9020106@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> I think this might fix the X bug...
I just posted an equivalent patch to Andi Kleen/AKPM/LKML.  I haven't =

tested to see if it actually helps yet, but it certainly makes entry.o =

look a lot cleaner.

    J
