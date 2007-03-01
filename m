From: Zachary Amsden <zach@vmware.com>
Subject: Re: Where does vmi_apply_boot_page_allocations ever get called?
Date: Thu, 01 Mar 2007 02:00:40 -0800
Message-ID: <45E6A448.8090101@vmware.com>
References: <45E69FAA.7080008@goop.org> <45E6A0CB.8050405@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45E6A0CB.8050405@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Jeremy Fitzhardinge wrote:
>   =

>> Because I need a hook for "do stuff after mem_map is valid" too.
>>     =


We didn't add a hook, but I can say it was somewhere in =

arch/i386/kernel/setup.c - should be after zone_sizes_init().

I'm no longer sure how to resurrect the original debug code, but it is =

still too useful to jettison at this point.  It was difficult to get all =

the nuances right..

>
> Oh, #ifdef CONFIG_DEBUG_PAGE_TYPE.  I was wondering when struct page
> grew a "type" field.
>   =


Yeah, this was private debugging for verifying that page typing was =

always accurate.  Turned off because we couldn't justify taking a struct =

page field.

Zach
