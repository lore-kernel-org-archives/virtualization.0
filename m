From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2 00/11] VSOCK: add vsock_test test suite
Date: Fri, 2 Aug 2019 09:55:08 +0200
Message-ID: <20190802075508.tumpam2vfmynuhd5@steredhat>
References: <20190801152541.245833-1-sgarzare@redhat.com>
	<PU1P153MB0169B265ECA51CB0AE1212DEBFDE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169B265ECA51CB0AE1212DEBFDE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dexuan Cui <decui@microsoft.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 01, 2019 at 04:16:37PM +0000, Dexuan Cui wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > Sent: Thursday, August 1, 2019 8:26 AM
> > 
> > The vsock_diag.ko module already has a test suite but the core AF_VSOCK
> > functionality has no tests.  This patch series adds several test cases that
> > exercise AF_VSOCK SOCK_STREAM socket semantics (send/recv,
> > connect/accept,
> > half-closed connections, simultaneous connections).
> > 
> > Dexuan: Do you think can be useful to test HyperV?
> 
> Hi Stefano,
> Thanks! This should be useful, though I have to write the Windows host side
> code to use the test program(s). :-)
> 

Oh, yeah, I thought so :-)

Let me know when you'll try to find out if there's a problem.

Thanks,
Stefano
