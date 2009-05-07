From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Thu, 07 May 2009 13:44:38 +0300
Message-ID: <4A02BB96.8070103__49192.0837703676$1241693292$gmane$org@redhat.com>
References: <20090507082841.GA31751@redhat.com>	
	<200905071651.24970.sheng@linux.intel.com>	
	<20090507092731.GH8112@parisc-linux.org>	
	<200905071740.16190.sheng@linux.intel.com>	
	<20090507095302.GI8112@parisc-linux.org>
	<1241691830.24385.6.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1241691830.24385.6.camel@concordia>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: michael@ellerman.id.au
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, Matthew Wilcox <willy@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Michael Ellerman wrote:
> Not to mention that there's no guarantee that you'll get as many
> interrupts as the device supports, so you should really be coding to
> cope with that anyway. Like the example in MSI-HOWTO.txt:
>
> 197 static int foo_driver_enable_msix(struct foo_adapter *adapter, int nvec)
> 198 {
> 199         while (nvec >= FOO_DRIVER_MINIMUM_NVEC) {
> 200                 rc = pci_enable_msix(adapter->pdev,
> 201                                      adapter->msix_entries, nvec);
> 202                 if (rc > 0)
> 203                         nvec = rc;
> 204                 else
> 205                         return rc;
> 206         }
> 207 
> 208         return -ENOSPC;
> 209 }
>
> So I agree, this patch is an improvement.
>   

I imagine this loop is present in many drivers.  So why not add a helper

static int pci_enable_msix_min(struct foo_adapter *adapter, int min_nvec)
{
	int nvec = 2048;

        while (nvec >= min_nvec) {
                rc = pci_enable_msix(adapter->pdev,
                                     adapter->msix_entries, nvec);
                if (rc == 0)
                        return nvec;
                else if (rc > 0)
                        nvec = rc;
                else
                        return rc;
        }
        return -ENOSPC;
}



-- 
error compiling committee.c: too many arguments to function
