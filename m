From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: What do we need to do to hit 2.6.19?
Date: Fri, 04 Aug 2006 18:45:07 -0700
Message-ID: <44D3F823.8000004@goop.org>
References: <44D39351.9070405@goop.org>
	<20060804235004.GQ2654@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060804235004.GQ2654@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> I believe this is fixed now, at least it's booting fine on my smp box now.
>
>  #define wrmsr_safe(msr,a,b) ({                                \
> -      u64 _l =3D ((u64)(a) << 32) | (b);                        \
> +      u64 _l =3D ((u64)(b) << 32) | (a);                        \
>        paravirt_ops.write_msr((msr),_l);                       \
>  })
>   =


But, but 'a' is obviously the msw ;-). =


Neato.  I'll give it a spin later this evening.

    J
