From: Pankaj Thakkar <pthakkar@vmware.com>
Subject: Re: RFC: Network Plugin Architecture (NPA) for vmxnet3
Date: Mon, 10 May 2010 13:46:43 -0700
Message-ID: <20100510204643.GH25364__17040.1871590459$1273524454$gmane$org@vmware.com>
References: <20100504230225.GP8323@vmware.com> <4BE1B217.80600@redhat.com>
	<20100505194417.GV8323@vmware.com> <4BE284CE.7010808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BE284CE.7010808@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 06, 2010 at 01:58:54AM -0700, Avi Kivity wrote:
> > We don't pass the whole VF to the guest. Only the BAR which is responsible for
> > TX/RX/intr is mapped into guest space.
> 
> Does the SR/IOV spec guarantee that you will have such a separation?

No. This is a guideline which we provided to IHVs and would have to be enforced
through testing/certification.

> How can you unmap the VF without guest cooperation?  If you're executing 
> Plugin code, you can't yank anything out.

In our Kawela plugin we don't have any reads from the memory space at all.
Hence you can yank the VF anytime (the code loaded in the guest address space
will keep on executing). Even if there were reads we can map the memory
pages to a NULL page and return 0xffffffff so that the plugin can detect this
and return an error to the shell. Remember there are no control operations in
the plugin and the code is really small (about 1k lines compared to 5k lines in
the full VF driver).

> 
> Are plugins executed with preemption/interrupts disabled?

Depends on the model. Today the plugin code for checking the TX/RX rings runs
in the deferred napi context.

> What ISAs do those plugins support?

x86 and x64.

Thanks,

-pankaj
