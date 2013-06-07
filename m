From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Fri, 7 Jun 2013 09:25:15 +0100
Message-ID: <CAFEAcA_5_AOVimiLpS_ezDV98rVU7cReM9ZyyE7oPZ_jGR5a9A@mail.gmail.com>
References: <20130530140132.GC21440@redhat.com>
	<874ndgujiw.fsf@rustcorp.com.au>
	<20130603101136.GB8649@redhat.com> <87fvwytpa1.fsf@rustcorp.com.au>
	<20130604064216.GD19433@redhat.com> <871u8g67d6.fsf@codemonkey.ws>
	<20130605140936.GB10604@redhat.com> <87ehcgr3wq.fsf@codemonkey.ws>
	<20130605151953.GA25987@redhat.com> <87bo7ktvaw.fsf@codemonkey.ws>
	<20130605162029.GB26561@redhat.com> <87li6obd2r.fsf@codemonkey.ws>
	<87y5anrjlf.fsf@rustcorp.com.au> <874ndbp9nf.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <874ndbp9nf.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On 6 June 2013 15:59, Anthony Liguori <aliguori@us.ibm.com> wrote:
> We would still use virtio-pci for existing devices.  Only new devices
> would use virtio-pcie.

Surely you'd want to support both for any new device, because
(a) transport is orthogonal to backend functionality
(b) not all existing machine models have pci-e ?

Or am I misunderstanding?

thanks
-- PMM
