From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] Re: [patch 21/26] Xen-paravirt_ops: Use the hvc
	console infrastructure for Xen console
Date: Fri, 16 Mar 2007 11:58:19 +0000
Message-ID: <C22036DB.BA67%keir__2138.69758085838$1174046398$gmane$org@xensource.com>
References: <20070316034123.9de92632.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070316034123.9de92632.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>
Cc: Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>, Chris@osdl.org, linux-kernel@vger.kernel.org, Keir Fraser <Keir.Fraser@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On 16/3/07 11:41, "Andrew Morton" <akpm@linux-foundation.org> wrote:

>> It's needed for writing data /after/ reading the consumer index that sho=
ws
>> you have space to write. Looking through xenbus_comms.c I think all the
>> barriers are correct except there is a spurious extra mb() in xb_read(),
>> where there is a later rmb() which is sufficient by itself. All the othe=
rs
>> have a purpose.
>> =

> =

> If Ingo couldn't work this out from reading the code then nobody else can,
> and we have a maintainability problem which can only be solved with
> adequate commenting.

Agreed. I've fixed up the commenting, removed the spurious mb(), and I just
need Jeremy to merge that change into the Xen pv_ops patchset. :-)

 -- Keir
