From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: lazy mmu and interrupts
Date: Wed, 28 Mar 2007 16:01:03 -0700
Message-ID: <460AF3AF.9030703@goop.org>
References: <460AA5DA.2090203@goop.org> <460AF657.6030902@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <460AF657.6030902@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Yup, that's a pretty serious bug.  Looks like the lazy mmu code needs
> to save and restore interrupts, or alternatively, have kmap_atomic
> turn off lazy_mmu if it is enabled.

Have you seen it?  I did a little lazy_mmu prototype last night and it
popped up pretty quickly.

    J
