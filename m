From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: [PATCH 0/2] xen: Miscelaneous xenbus cleanups
Date: Wed, 4 Jan 2012 11:39:17 +0000
Message-ID: <1325677158.25206.244.camel@zakaz.uk.xensource.com>
References: <1325619731-13936-1-git-send-email-haogangchen@gmail.com>
	<1325669095.25206.176.camel@zakaz.uk.xensource.com>
	<1325669689.25206.181.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1325669689.25206.181.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Haogang Chen <haogangchen@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Just a couple of things I noticed while reviewing Haogang's patch.
Applies on top of my suggested replacement for that patch (in
<1325669689.25206.181.camel@zakaz.uk.xensource.com>).

Not extensively tested but I did run it in dom0 and start both and HVM
and PV guest.

Ian.
