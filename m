From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Question regarding Virtio Console and Remoteproc
Date: Fri, 1 Jun 2012 10:51:38 +0300
Message-ID: <CAK=WgbY9cXByKXEnpSvVr3dCecmKyumAQ6ffX8_2ghsAr2haEQ@mail.gmail.com>
References: <81C3A93C17462B4BBD7E272753C10579232F4FB338@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <81C3A93C17462B4BBD7E272753C10579232F4FB338@EXDCVYMBSTM005.EQ1STM.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Cc: Amit Shah <amit.shah@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 1, 2012 at 10:31 AM, Sjur BRENDELAND
<sjur.brandeland@stericsson.com> wrote:
> =A0 =A0 =A0 =A0if (virtio_has_feature(vdev, VIRTIO_CONSOLE_USE_DMA_MEM)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_addr_t dma;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf =3D dma_alloc_coherent(dev, size, &dma=
, GFP_KERNEL);
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf =3D kmalloc(count, GFP_KERNEL);

Something along those lines is also needed for remote processors which
access memory via an IOMMU (e.g. OMAP4's M3 and DSP).

Allocating the memory via the DMA API will seamlessly configure the
relevant IOMMU as needed, and will make the buffers accessible to the
remote processors.

Thanks,
Ohad.
