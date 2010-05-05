From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: RFC: Network Plugin Architecture (NPA) for vmxnet3
Date: Tue, 4 May 2010 17:05:31 -0700
Message-ID: <20100504170531.1e7122da__43518.7344476164$1273018025$gmane$org@nehalam>
References: <20100504230225.GP8323@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

On Tue, 4 May 2010 16:02:25 -0700
Pankaj Thakkar <pthakkar@vmware.com> wrote:

> Device passthrough technology allows a guest to bypass the hypervisor and drive
> the underlying physical device. VMware has been exploring various ways to
> deliver this technology to users in a manner which is easy to adopt. In this
> process we have prepared an architecture along with Intel - NPA (Network Plugin
> Architecture). NPA allows the guest to use the virtualized NIC vmxnet3 to
> passthrough to a number of physical NICs which support it. The document below
> provides an overview of NPA.
> 
> We intend to upgrade the upstreamed vmxnet3 driver to implement NPA so that
> Linux users can exploit the benefits provided by passthrough devices in a
> seamless manner while retaining the benefits of virtualization. The document
> below tries to answer most of the questions which we anticipated. Please let us
> know your comments and queries.
> 
> Thank you.
> 
> Signed-off-by: Pankaj Thakkar <pthakkar@vmware.com>


Code please. Also, it has to work for all architectures not just VMware and
Intel.
