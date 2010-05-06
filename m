From: Shreyas Bhatewara <sbhatewara@vmware.com>
Subject: RE: [Pv-drivers] RFC: Network Plugin Architecture (NPA) for vmxnet3
Date: Thu, 6 May 2010 00:25:24 -0700
Message-ID: <89E2752CFA8EC044846EB8499819134102AF2D23E6__1417.71346466175$1273130785$gmane$org@EXCH-MBX-4.vmware.com>
References: <89E2752CFA8EC044846EB8499819134102AF2896F5@EXCH-MBX-4.vmware.com>
	<C807719A.2E910%scofeldm@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <C807719A.2E910%scofeldm@cisco.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Scott Feldman <scofeldm@cisco.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dtor@vmware.com>
Cc: Pankaj Thakkar <pthakkar@vmware.com>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Scott Feldman [mailto:scofeldm@cisco.com]
> Sent: Wednesday, May 05, 2010 7:04 PM
> To: Shreyas Bhatewara; Arnd Bergmann; Dmitry Torokhov
> Cc: Christoph Hellwig; pv-drivers@vmware.com; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; virtualization@lists.linux-
> foundation.org; Pankaj Thakkar
> Subject: Re: [Pv-drivers] RFC: Network Plugin Architecture (NPA) for
> vmxnet3
> 
> On 5/5/10 10:29 AM, "Dmitry Torokhov" <dtor@vmware.com> wrote:
> 
> > It would not be a binary blob but software properly released under
> GPL.
> > The current plan is for the shell to enforce GPL requirement on the
> > plugin code, similar to what module loaded does for regular kernel
> > modules.
> 
> On 5/5/10 3:05 PM, "Shreyas Bhatewara" <sbhatewara@vmware.com> wrote:
> 
> > The plugin image is not linked against Linux kernel. It is OS
> agnostic infact
> > (Eg. same plugin works for Linux and Windows VMs)
> 
> Are there any issues with injecting the GPL-licensed plug-in into the
> Windows vmxnet3 NDIS driver?
> 
> -scott
