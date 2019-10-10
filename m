From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2 07/11] VSOCK: add AF_VSOCK test cases
Date: Thu, 10 Oct 2019 10:47:44 +0200
Message-ID: <20191010084744.n46t3ryv7rilkpk2__8978.67610199086$1570697282$gmane$org@steredhat>
References: <20190801152541.245833-1-sgarzare@redhat.com>
	<20190801152541.245833-8-sgarzare@redhat.com>
	<CAGxU2F4N5ACePf6YLQCBFMHPu8wDLScF+AGQ2==JAuBUj0GB-A@mail.gmail.com>
	<20191009151503.GA13568@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191009151503.GA13568@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 09, 2019 at 04:15:03PM +0100, Stefan Hajnoczi wrote:
> On Wed, Oct 09, 2019 at 12:03:53PM +0200, Stefano Garzarella wrote:
> > Hi Stefan,
> > I'm thinking about dividing this test into single applications, one
> > for each test, do you think it makes sense?
> > Or is it just a useless complication?
> 
> I don't mind either way but personally I would leave it as a single
> program.
> 

Okay, since I had the doubt it was a useless complication and you prefer
a single application, I continue on this way :-)

Thanks,
Stefano
