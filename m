From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: SR-PCIM support in Xen
Date: Tue, 1 Nov 2016 13:47:56 +0000
Message-ID: <8520D5D51A55D047800579B094147198259A94C3@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "xen-devel-request@lists.xenproject.org" <xen-devel-request@lists.xenproject.org>"xen-devel-request@lists.xenproject.org" <xen-devel-request@lists.xenproject.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "jgross@suse.com" <jgross@suse.com>, "david.vrabel@citrix.com" <david.vrabel@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi All,

Is there any support for software mailbox communication between PF and VF driver in Xen ?

As per the following link:
http://www-archive.xenproject.org/files/xensummitboston08/Xen-SR-IOV.pdf
It says that for software based virtual mailbox we require SR-PCIM support.

So for this purpose is SR-PCIM implemented as part of Xen ?
Or is there any other method that Xen provides for communication between PF & VF ?

Thanks & regards,
Bharat
