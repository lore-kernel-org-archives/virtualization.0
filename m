From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [Q] guest identification and host runtime PM
Date: Thu, 9 Jan 2020 14:56:16 +0100
Message-ID: <20200109135615.GA20339@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I'm working on a VirtIO / vhost audio virtualisation solution [1,2]
and although it's already working rather well, some points still need
clarification.

1. Guest identification. Is there a standard way to identify guests in
   a vhost driver? We need to send different audio topology to
   different guests, therefore we need a way to reliably identify
   them.

2. Runtime PM. Is there a standard or a preferred way to implement
   runtime PM on the host side to guarantee that the device is always
   powered on when guests need it and can be runtime suspended
   otherwise?

Thanks
Guennadi

[1] https://github.com/thesofproject/sof-docs/pull/155
[2] https://github.com/thesofproject/linux/pull/1501
