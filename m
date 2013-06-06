From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Thu, 06 Jun 2013 06:53:26 -0700
Message-ID: <51B09456.6050608@zytor.com>
References: <87ehcgr3wq.fsf@codemonkey.ws> <20130605151953.GA25987@redhat.com>
	<87bo7ktvaw.fsf@codemonkey.ws> <20130605162029.GB26561@redhat.com>
	<51AFA92B.2030203@zytor.com> <87fvwwmdmf.fsf@codemonkey.ws>
	<51AFB3DD.1050902@zytor.com> <874ndcb47i.fsf@codemonkey.ws>
	<51AFC4A6.6070607@zytor.com> <877gi8nk9e.fsf@codemonkey.ws>
	<20130606063432.GQ4725@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130606063432.GQ4725@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On 06/05/2013 11:34 PM, Gleb Natapov wrote:
>>
>> SeaBIOS runs the virtio code in 32-bit mode with a flat memory layout.
>> There are loads of ASSERT32FLAT()s in the code to make sure of this.
>>
> Well, not exactly. Initialization is done in 32bit, but disk
> reads/writes are done in 16bit mode since it should work from int13
> interrupt handler. The only way I know to access MMIO bars from 16 bit
> is to use SMM which we do not have in KVM.
> 

In some ways it is even worse for PXE, since PXE is defined to work from
16-bit protected mode... but the mechanism to request a segment mapping
for the high memory area doesn't actually work.

	-hpa
