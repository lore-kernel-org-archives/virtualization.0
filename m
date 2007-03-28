From: Zachary Amsden <zach@vmware.com>
Subject: Re: lazy mmu and interrupts
Date: Wed, 28 Mar 2007 15:12:23 -0800
Message-ID: <460AF657.6030902@vmware.com>
References: <460AA5DA.2090203@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <460AA5DA.2090203@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Do you disable interrupts when lazy_mmu is active?  Otherwise, it seems
> to me that drivers will have problems using kmap_atomic() within an
> interrupt routine...
>   =


Yup, that's a pretty serious bug.  Looks like the lazy mmu code needs to =

save and restore interrupts, or alternatively, have kmap_atomic turn off =

lazy_mmu if it is enabled.

Zach
