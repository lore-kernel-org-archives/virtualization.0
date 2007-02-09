From: Zachary Amsden <zach@vmware.com>
Subject: Re: Paravirt-ops VMI / Xen / lrustyvisor merge status
Date: Thu, 08 Feb 2007 22:58:23 -0800
Message-ID: <45CC1B8F.2040507@vmware.com>
References: <45CC0672.7090201@vmware.com>
	<1171000474.2718.8.camel@localhost.localdomain>
	<45CC10B7.2060100@vmware.com> <45CC13B8.7040303@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45CC13B8.7040303@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>   =

>> I think the only other open issue we had was how to cleanly do the
>> sysenter disable for Xen.  We want it on for sure, and so does native,
>> but Xen needs to disable it.
>>     =

>
> You want sysenter as the preferred way of getting into the kernel?
>   =


Yup.

Zach
