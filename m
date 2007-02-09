From: Andi Kleen <ak@suse.de>
Subject: Re: Paravirt-ops VMI / Xen / lrustyvisor merge status
Date: Fri, 9 Feb 2007 08:21:48 +0100
Message-ID: <200702090821.48478.ak@suse.de>
References: <45CC0672.7090201@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45CC0672.7090201@vmware.com>
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
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 09 February 2007 06:28, Zachary Amsden wrote:
> So, as 2.6.21-rc1 is approaching, what is the upstream merge status for =

> the paravirt-ops backends?  I believe VMI is in Andi's tree, plus or =

> minus some bugfixes that are still being whittled in, but Andi, do you =

> think the VMI code is in good shape for merging?

I don't know in what shape it is in as it hasn't been tested by me.
From the looks it looks reasonable enough for merging. But I didn't like
some of your recent updates.

-Andi
