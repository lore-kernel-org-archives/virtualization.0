From: Christoph Hellwig <hch@infradead.org>
Subject: Re: RFC: Network Plugin Architecture (NPA) for vmxnet3
Date: Wed, 5 May 2010 13:23:16 -0400
Message-ID: <20100505172316.GA25338__15756.9735464223$1273080348$gmane$org@infradead.org>
References: <20100504230225.GP8323@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100504230225.GP8323@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pankaj Thakkar <pthakkar@vmware.com>
Cc: pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 04, 2010 at 04:02:25PM -0700, Pankaj Thakkar wrote:
> The plugin image is provided by the IHVs along with the PF driver and is
> packaged in the hypervisor. The plugin image is OS agnostic and can be loaded
> either into a Linux VM or a Windows VM. The plugin is written against the Shell
> API interface which the shell is responsible for implementing. The API

We're not going to add any kind of loader for binry blobs into kernel
space, sorry.  Don't even bother wasting your time on this.
