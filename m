From: Horia Geanta <horia.geanta@nxp.com>
Subject: Re: [PATCH v2 06/35] crypto: Use kmemdup rather than duplicating its
	implementation
Date: Wed, 3 Jul 2019 17:10:26 +0000
Message-ID: <VI1PR0402MB3485A113C5FB19DC556B678B98FB0__8782.46617955796$1563995308$gmane$org@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20190703162708.32137-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S . Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On 7/3/2019 7:27 PM, Fuqian Huang wrote:
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistake=
s.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
> =

> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
Reviewed-by: Horia Geant=E3 <horia.geanta@nxp.com>

Thanks,
Horia
