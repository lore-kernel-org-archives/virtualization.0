From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v9 17/19] drm/virtio: kconfig: Fix recursive dependency
	issue.
Date: Tue, 20 Sep 2016 00:18:48 +0100
Message-ID: <CACvgo52_g7anGBd9HTUyYsbp5QmQEk9LR3nNHgSTgjQ29G3ViA@mail.gmail.com>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
	<1473081421-16555-18-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1473081421-16555-18-git-send-email-peter.griffin@linaro.org>
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
Cc: devicetree <devicetree@vger.kernel.org>, kernel@stlinux.com, vinod.koul@intel.com, lee.jones@linaro.org, linux-remoteproc@vger.kernel.org, patrice.chotard@st.com, ML dri-devel <dri-devel@lists.freedesktop.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, dmaengine@vger.kernel.org, dan.j.williams@intel.com, bjorn.andersson@linaro.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On 5 September 2016 at 14:16, Peter Griffin <peter.griffin@linaro.org> wrote:
> ST_SLIM_REMOTEPROC must select REMOTEPROC, which exposes the following
> recursive dependency.
>
From a humble skim through remoteproc, drm and a few other subsystems
I think the above is wrong. All the drivers (outside of remoteproc),
that I've seen, depend on the core component, they don't select it.

Furthermore most places explicitly hide the drivers from the menu if
the core component isn't enabled.

Is there something that requires such a different/unusual behaviour in
remoteproc ?

Regards,
Emil
