From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [virtio-dev] Re: [PATCH v10] virtio-net: add Max MTU
	configuration field
Date: Wed, 14 Sep 2016 09:18:35 +0200
Message-ID: <20160914091835.74b4969e.cornelia.huck__1643.82245061478$1473847643$gmane$org@de.ibm.com>
References: <1473779892-6234-1-git-send-email-aconole@redhat.com>
	<20160914000341-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160914000341-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Victor Kaplansky <vkaplans@redhat.com>, virtio-dev@lists.oasis-open.org, Maxime Coquelin <maxime.coquelin@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 14 Sep 2016 00:17:28 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Sep 13, 2016 at 11:18:12AM -0400, Aaron Conole wrote:

(...)

> > If negotiated, the driver uses \field{mtu} as
> > +    the maximum MTU value supplied to the driver.
> 
> Drop "supplied to the driver" here?

Reword as "If negotiated, the device uses \field{mtu} to supply the
maximum MTU value supported to the driver." ?

I agree with your other comments. Other than that, the update looks
good.
