From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [RFC PATCH 04/12] s390/cio: introduce cio DMA pool
Date: Fri, 12 Apr 2019 14:12:31 +0200 (CEST)
Message-ID: <alpine.LFD.2.21.1904121343040.1771@schleppi>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
	<20190404231622.52531-5-pasic@linux.ibm.com>
	<alpine.LFD.2.21.1904111955520.2283@schleppi>
	<20190412132010.3c74cb63@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190412132010.3c74cb63@oc2783563651>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 12 Apr 2019, Halil Pasic wrote:
> On Thu, 11 Apr 2019 20:25:01 +0200 (CEST)
> Sebastian Ott <sebott@linux.ibm.com> wrote:
> > I don't think we should use this global DMA pool. I guess it's OK for
> > stuff like airq (where we don't have a struct device at hand) but for
> > CCW we should use the device we have. Yes, this way we waste some memory
> > but all dma memory a device uses should fit in a page - so the wastage
> > is not too much.
> > 
> 
> Is what you envision an own gen_pool on for each subchannel (e.g. a
> struct io_subchannel member)?

Either that or if that's too much overhead simply map a page and create
a struct containing the few dma areas for that device.

> I'm struggling with understanding the expected benefits of a
> per-subchannel pool/allocator. Can you please tell me what benefits do
> you expect (over the current approach)?

Logically DMA is a capability of a device and the whole DMA API is build
around devices. Working around that just feels wrong. For practical
matters: DMA debugging will complain about misuse of a specific device or
driver.

> I understand you idea is to keep the CIO global pool for stuff that can
> not be tied to a single device (i.e. ariq). So the per device stuff would
> also mean more code. Would you be OK with postponing this alleged
> enhancement (i.e. implement it as a patch on top of this series)?

I don't like it but it's just in-kernel usage which we can change at any
time. So if it helps you to do it that way, why not..
