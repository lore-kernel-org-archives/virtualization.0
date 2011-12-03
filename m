From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC] virtio: use mandatory barriers for remote processor vdevs
Date: Sat, 3 Dec 2011 08:01:09 +0200
Message-ID: <CAK=WgbYgbShjuFozOQh5Zk+Dh7jymrvtSiVFHzDLB4Nk0zMNaw@mail.gmail.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
	<1322867384.11728.20.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1322867384.11728.20.camel@pasglop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Dec 3, 2011 at 1:09 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Have you measured the impact of using normal barriers (non-SMP ones)
> like we use on normal HW drivers unconditionally ?
>
> IE. If the difference is small enough I'd say just go for it and avoid
> the bloat.

I agree.

MST wanted to give this a try this week. If all goes well and there's
no unreasonable regression, we'd just switch to mandatory barriers.

Ohad.
