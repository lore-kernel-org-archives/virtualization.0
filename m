From: Zachary Amsden <zach@vmware.com>
Subject: Re: Paravirt-ops VMI / Xen / lrustyvisor merge status
Date: Thu, 08 Feb 2007 23:35:07 -0800
Message-ID: <45CC242B.4010909@vmware.com>
References: <45CC0672.7090201@vmware.com> <200702090821.48478.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200702090821.48478.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> On Friday 09 February 2007 06:28, Zachary Amsden wrote:
>   =

>> So, as 2.6.21-rc1 is approaching, what is the upstream merge status for =

>> the paravirt-ops backends?  I believe VMI is in Andi's tree, plus or =

>> minus some bugfixes that are still being whittled in, but Andi, do you =

>> think the VMI code is in good shape for merging?
>>     =

>
> I don't know in what shape it is in as it hasn't been tested by me.
> From the looks it looks reasonable enough for merging. But I didn't like
> some of your recent updates.
>   =


If you think any of them can be done cleaner, let me know and I will =

redo the patches.

The USE_REAL_TIME_DELAY stuff is really ugly, and mostly a hack.  You =

can drop it.  Our fix should be to not let the virtual hardware drive =

the physical hardware that fast, or to recognize the panic state in =

delay loops and start respecting instead of ignoring delay.

Zach
