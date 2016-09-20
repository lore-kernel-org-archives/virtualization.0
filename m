From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v9 17/19] drm/virtio: kconfig: Fix recursive dependency
	issue.
Date: Tue, 20 Sep 2016 08:20:48 +0100
Message-ID: <CACvgo533SrCHV9V_L3_UA8sTPWKyC9HA8k5BqNad+1eaoWPLmA@mail.gmail.com>
References: <1474277660-5196-1-git-send-email-peter.griffin@linaro.org>
	<1474277660-5196-2-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2792522081930439629=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1474277660-5196-2-git-send-email-peter.griffin@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "kernel@stlinux.com" <kernel@stlinux.com>, "airlied@linux.ie" <airlied@linux.ie>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, "vinod.koul@intel.com" <vinod.koul@intel.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============2792522081930439629==
Content-Type: multipart/alternative; boundary=047d7bb04be097169a053ceb4474

--047d7bb04be097169a053ceb4474
Content-Type: text/plain; charset=UTF-8

On Monday, 19 September 2016, Peter Griffin <peter.griffin@linaro.org>
wrote:

> ST_SLIM_REMOTEPROC must select REMOTEPROC, which exposes the following
> recursive dependency.
>
> It must not select, it must depend? Did you miss my earlier
question/suggestion that mentions that ?

Regards,
Emil

--047d7bb04be097169a053ceb4474
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Monday, 19 September 2016, Peter Griffin &lt;<a href=3D"mailto:peter.gri=
ffin@linaro.org">peter.griffin@linaro.org</a>&gt; wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">ST_SLIM_REMOTEPROC must select REMOTEPROC, which exposes th=
e following<br>
recursive dependency.<br>
<br></blockquote><div>It must not select, it must depend? Did you miss my e=
arlier question/suggestion that mentions that ?</div><div><br></div><div>Re=
gards,</div><div>Emil</div>

--047d7bb04be097169a053ceb4474--

--===============2792522081930439629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2792522081930439629==--
