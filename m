From: "Huang2, Wei" <Wei.Huang2@amd.com>
Subject: RE: [Xen-devel] Re: [patch 21/26] Xen-paravirt_ops: Use the hvc
	console infrastructure for Xen console
Date: Fri, 16 Mar 2007 14:01:50 -0500
Message-ID: <7D748C767B7FA541A8AC5504A4C89A23015685C4@SAUSEXMB2.amd.com>
References: <C22036DB.BA67%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <C22036DB.BA67%keir@xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Keir Fraser <keir@xensource.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Chris@osdl.org, linux-kernel@vger.kernel.org, Keir Fraser <Keir.Fraser@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

But it is shorter than from JFK or Newark. =


-----Original Message-----
From: xen-devel-bounces@lists.xensource.com
[mailto:xen-devel-bounces@lists.xensource.com] On Behalf Of Keir Fraser
Sent: Friday, March 16, 2007 6:58 AM
To: Andrew Morton; Keir Fraser
Cc: xen-devel@lists.xensource.com; Andi Kleen;
linux-kernel@vger.kernel.org; Keir Fraser; Wright;
virtualization@lists.osdl.org; Ingo Molnar; Chris@smtp.osdl.org
Subject: Re: [Xen-devel] Re: [patch 21/26] Xen-paravirt_ops: Use the hvc
console infrastructure for Xen console

On 16/3/07 11:41, "Andrew Morton" <akpm@linux-foundation.org> wrote:

>> It's needed for writing data /after/ reading the consumer index that
shows
>> you have space to write. Looking through xenbus_comms.c I think all
the
>> barriers are correct except there is a spurious extra mb() in
xb_read(),
>> where there is a later rmb() which is sufficient by itself. All the
others
>> have a purpose.
>> =

> =

> If Ingo couldn't work this out from reading the code then nobody else
can,
> and we have a maintainability problem which can only be solved with
> adequate commenting.

Agreed. I've fixed up the commenting, removed the spurious mb(), and I
just
need Jeremy to merge that change into the Xen pv_ops patchset. :-)

 -- Keir


_______________________________________________
Xen-devel mailing list
Xen-devel@lists.xensource.com
http://lists.xensource.com/xen-devel
