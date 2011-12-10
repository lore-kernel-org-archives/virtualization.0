From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [RFC 6/11] virtio_pci: don't use the legacy driver if we find
	the new PCI capabilities.
Date: Sat, 10 Dec 2011 23:18:38 +0200
Message-ID: <1323551918.32487.34.camel@lappy>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <871usfgxg9.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <871usfgxg9.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2011-12-08 at 21:08 +1030, Rusty Russell wrote:
> With module option to override.  I assume I can call
> pci_find_capability() before pci_request_regions? 

I don't think thats safe.

-- 

Sasha.
