From: Zachary Amsden <zach@vmware.com>
Subject: Re: pgd_alloc and [cd]tors
Date: Thu, 16 Nov 2006 21:14:52 -0800
Message-ID: <455D454C.9040808@vmware.com>
References: <455D0773.2050906@goop.org> <455D1A0C.6010001@vmware.com>
	<455D42C7.4070203@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <455D42C7.4070203@goop.org>
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
> Zachary Amsden wrote:
>   =

>> Actually, vmalloc mapping replication is not quite straightforward -
>> you have to replicate it under locks and track all pgds using pgd_list
>> if you support large pages.
>>     =

>
> But that machinery already exists.  It would continue to work under PAE
> wouldn't it?
>   =


No, it doesn't exist under PAE, since PAE uses a common pgd[3] therefore =

the init_mm pgd never needs changing for large page / split page PD =

transitions.  The code is there for non-PAE, but compiled out of the PAE =

version.

Zach
