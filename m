From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: proposed interface change for setting the ldt
Date: Fri, 18 Aug 2006 14:03:23 +0100
Message-ID: <44E5BA9B.9080509@goop.org>
References: <44E599A3.6020907@goop.org> <44E5B68C.2000302@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44E5B68C.2000302@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Jeremy Fitzhardinge wrote:
>>     set_ldt(const struct desc_struct *ldt, int num_entries);
>>   =

> Make that
>
>     set_ldt(unsigned cpu, const struct desc_struct *ldt, int =

> num_entries);

Or maybe not.  The current code assumes that cpu is the current cpu =

anyway;  the implementation can use smp_processor_id() if it needs it =

anyway (Xen doesn't).

    J
