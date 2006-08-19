From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: proposed interface change for setting the ldt
Date: Sat, 19 Aug 2006 04:18:19 +0100
Message-ID: <44E682FB.6030609@goop.org>
References: <44E599A3.6020907@goop.org> <44E621BA.6090001@vmware.com>
	<44E679ED.6010300@goop.org> <44E681B8.3020804@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44E681B8.3020804@vmware.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> The paravirt-op just got a lot harder to implement, so there is a cost =

> to the simpler interface.

I don't see why it is a "lot" harder.  It might take 5 lines of code =

rather than jumping straight into the ROM, but it doesn't seem like huge =

complexity.

> I just think it's really weird to have LDT not described in the GDT, =

> but LDT is weird anyways.

It gets excluded as part of a broader test which also prevents any =

table, but specifically the LDT, from referring to an LDT (on the =

grounds that its hard to reason about, and may be undefined).

    J
